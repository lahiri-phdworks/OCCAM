from __future__ import print_function
from torch import nn
import torch.nn.functional as F
import torch
import numpy as np
import os
import pickle

torch.set_printoptions(sci_mode=False)
OCCAM_HOME = os.environ['OCCAM_HOME']


def create_emb_layer(embeddings_file, requires_grad=False):
    """
    Pass a embeddings file. 
    """
    embedding_dump = np.load(emb_file, allow_pickle=True)
    num_embedding, dimensions_embedding = embedding_dump.shape

    print(f"No. of Embeddings : {num_embedding}")
    print(f"Embedding dtype : ", embedding_dump.dtype)

    emb_layer = nn.Embedding(num_embedding + 1, dimensions_embedding)
    emb_layer.weight = nn.Parameter(torch.from_numpy(emb_matrix))
    emb_layer.weight.requires_grad = requires_grad

    return emb_layer, num_embedding, dimensions_embedding


def create_gru_layer(input_size, hidden_size, hidden_args, num_layers):
    """
    Create a 2-GRU + 3 layer fully-connected network
    """
    embeddings_file = OCCAM_HOME + \
        'razor/deepoccam/inst2vec/published_results/data/vocabulary/emb.p'
    emb_layer, num_embedding, dimensions_embedding = create_emb_layer(
        embeddings_file, True)

    # Use torch.nn.GRU, torch.nn.Linear fully_connected_1
