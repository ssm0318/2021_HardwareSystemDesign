2014-17831 김재원

## Implementation Details
1. The matrix is stored as a 1D vector. Thus, the index values for storage/access are computed as `v_size_*row + col`.
2. As introduced in the lectures slides, the vector values are copied from the input and the matrix values are copied from the weight matrix (i.e., `large_mat`).
3. For both the vector and the matrix, values are initialized to zero in the case that the block size exceeds the number of leftover values to be computed.

## Results
- The smaller the block size, the more average number of calls + time it takes to complete the MV multiplication.
- Block MV Multiplication requires more time than usual MV multiplications, as expected.
- Accuracies turned out to be the same for all block sizes, as expected.

## 64x64
### Initial Results
```
{'accuracy': 0.098,
 'avg_num_call': 627,
 'm_size': 64,
 'total_image': 10000,
 'total_time': 24.585601091384888,
 'v_size': 64}
```

### After Implementation
```
{'accuracy': 0.9159,
 'avg_num_call': 627,
 'm_size': 64,
 'total_image': 10000,
 'total_time': 54.85524106025696,
 'v_size': 64}
```

## 16x16
### Initial Results
```
{'accuracy': 0.098,
 'avg_num_call': 9375,
 'm_size': 16,
 'total_image': 10000,
 'total_time': 21.55428695678711,
 'v_size': 16}
```

### After Implementation
```
{'accuracy': 0.9159,
 'avg_num_call': 9375,
 'm_size': 16,
 'total_image': 10000,
 'total_time': 50.996262073516846,
 'v_size': 16}
```

## 8x16
### Initial Results
```
{'accuracy': 0.098,
 'avg_num_call': 18750,
 'm_size': 8,
 'total_image': 10000,
 'total_time': 24.31095600128174,
 'v_size': 16}
```

### After Implementation
```
{'accuracy': 0.9159,
 'avg_num_call': 18750,
 'm_size': 8,
 'total_image': 10000,
 'total_time': 55.57417893409729,
 'v_size': 16}
```

## 16x8
### Initial Results
```
{'accuracy': 0.098,
 'avg_num_call': 18750,
 'm_size': 16,
 'total_image': 10000,
 'total_time': 26.016726970672607,
 'v_size': 8}
```

### After Implementation
```
{'accuracy': 0.9159,
 'avg_num_call': 18750,
 'm_size': 16,
 'total_image': 10000,
 'total_time': 57.759015798568726,
 'v_size': 8}
```
