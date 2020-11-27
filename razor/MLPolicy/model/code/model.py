op_version_set = 0


def forward(self,
            x: Tensor) -> Tensor:
    _0 = self.fc1
    weight = _0.weight
    bias = _0.bias
    _1 = self.fc2
    weight0 = _1.weight
    bias0 = _1.bias
    s = ops.prim.NumToTensor(torch.size(x, 1))
    input = torch.view(x, [-1, int(torch.mul(s, CONSTANTS.c0))])
    input0 = torch.addmm(bias, input, torch.t(weight), beta=1, alpha=1)
    input1 = torch.relu(input0)
    input2 = torch.addmm(bias0, input1, torch.t(weight0), beta=1, alpha=1)
    input3 = torch.relu(input2)
    return torch.softmax(input3, 1)
