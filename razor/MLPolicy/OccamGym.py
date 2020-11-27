import gym
from gym import error, spaces, utils
from gym.utils import seeding
import subprocess
import os
import time
import Previrt_pb2
import Previrt_pb2_grpc
import grpc
import json
import numpy as np
import signal

FNULL = open(os.devnull, 'w')


class OccamGymEnv(gym.Env):
    def __init__(self, workdir, mode, idx, metric, connection):
        self.idx = idx
        self.counter = 0
        self.workdir = workdir
        self.mode = mode
        self.connection = connection
        self.metric = metric
        self._occam_proc_pid = None
        self._server_proc_pid = None
        self.action_space = spaces.Discrete(2)
        self._get_meta()
        self.observation_space = spaces.Box(
            np.zeros(24), 2*np.asarray(self.metadata["maxx"][:-3]), dtype=np.uint8)
        self._start_server()

    def _get_obs(self):
        return self.step(action=None)

    def _get_meta(self):
        with open(os.path.join(self.workdir, "metadata.json"), "r") as metafile:
            self.metadata = json.load(metafile)

    def step(self, action, q_yes=-1, q_no=-1, state_encoded="EMPTY"):
        if action is not None:
            prediction = Previrt_pb2.Prediction(
                q_no=q_no, q_yes=q_yes, state_encoded=state_encoded, pred=bool(action))
        else:
            prediction = Previrt_pb2.Prediction(
                q_no=-99, q_yes=-99, state_encoded=state_encoded, pred=False)
        with grpc.insecure_channel(self.connection) as channel:
            stub = Previrt_pb2_grpc.QueryOracleStub(channel)
            response = stub.Step(prediction)
            obs = list(response.obs)
            reward = response.reward
            done = response.done
            info = response.info
            if done:
                info = {"is_success": True}
            else:
                info = {"info": info}
        return obs, reward, done, info

    def _start_server(self):
        server_log = open(os.path.join(
            self.workdir, "server_%s_log" % self.idx), "w")
        server_cmd = ["python3", "Connector.py", "--idx", self.idx,
                      "--metric", self.metric, "--workdir", self.workdir]
        print(server_cmd)
        server_proc = subprocess.Popen(server_cmd, stdout=server_log)
        self._server_proc_pid = server_proc.pid

    def reset(self):
        print("Reset env...")
        if self._occam_proc_pid is not None:
            os.kill(self._occam_proc_pid, signal.SIGTERM)  # or signal.SIGKILL
            print("Kill the current Occam process")
        occam_command = ["./build.sh", "--devirt", "none", "-g", "-grpc-conn",
                         self.connection, "-epsilon", "-1", "-folder", self.idx]
        occam_proc = subprocess.Popen(
            occam_command, cwd=self.workdir, stdout=FNULL)
        self._occam_proc_pid = occam_proc.pid
        # keep querying until the 1st obs is returned
        time.sleep(2)
        while True:
            try:
                time.sleep(1)
                obs, reward, done, info = self._get_obs()
                if obs[0] != -1:
                    print("env is reset. Got 1st state")
                    return obs
            except Exception as e:
                print(e)

    def render(self):
        pass

    def close(self):
        print("Close env...")
        os.kill(self._server_proc_pid, signal.SIGTERM)  # or signal.SIGKILL
