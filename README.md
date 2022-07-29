# Metric Dimension

This repository contains code for checking whether a subset of vertices resolves a graph.

## Background

### Metric dimension

### Graphs of interest

## Running the code

The code is written in Sage. The simplest way to run it is by copy-pasting the contents of `filename` into [SageMathCell](https://sagecell.sagemath.org/). If you want to run larger examples, which may take longer, it is recommended to use Sage in [CoCalc](https://cocalc.com/) or install [SageMath](https://www.sagemath.org/) on your computer. 

### Example 1

Consider a $3\times 3\times 3$ board whose $27$ cells are represented by tuples $(i,j,k)$ with $1\leq i,j,k\leq 3$. We can enter a candidate $W$ as a list of tuples `[i,j,k]` and check which pairs of vertices are unresolved. For example, if we evaluate

```
W=[[1,1,1],[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
print("unresolved classes:")
UnresolvedClasses(W,3,3,3)
```
we get an ouput of
```
unresolved classes: []
```
Since we got an empty list `[]`, the set $W$ resolves the board. In contrast, if we remove `[1,1,1]` from the set and evaluate
```
W2=[[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
print("unresolved classes:")
UnresolvedClasses(W2,3,3,3)
```
we get an output of
```
unresolved classes:
[[[1, 1, 1], [1, 2, 3], [3, 2, 3]],
 [[1, 3, 2], [3, 3, 2]],
 [[2, 1, 2], [2, 2, 2]],
 [[2, 3, 1], [2, 3, 3]]]
 ```
This means there are four classes of unresolved vertices. Consider the last class, `[[2,3,1],[2,3,3]]`. If we compare `[2,3,1]` with the landmarks in `W2=[[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]`, we see that it has a coordinate in common with all except for the first landmark. So `[2,3,1]` is *seen* by all but the first landmark. Similarly, `[2,3,3]` is *seen* by all except the first landmark. So `[2,3,1]` and `[2,3,3]` are unresolved because they are seen by the same set of landmarks. This means `W2` is not a resolving set.

### Example 2

Consider a $6\times 6\times 6$ board whose $216$ cells are represented by tuples $(i,j,k)$ with $1\leq i,j,k\leq 6$. This time, we will enter our set $W$ as a matrix, where symbol $k$ in row $i$, column $j$ corresponds to landmark $(i,j,k)$. We will use a zero to indicate no landmark. We can then use the `LatinRecToLandmarks` function to convert the matrix to a list of tuples. For example, evaluating
```
Wmatrix=matrix([[0,1,0,0,0,0],[1,2,0,0,0,0],[0,0,2,3,0,0],[0,0,3,4,0,0],[0,0,0,0,4,5],[0,0,0,0,5,6]])
W=LatinRecToLandmarks(Wmatrix)
print("matrix form:",Wmatrix)
print("list form:",W)
```
yields
```
matrix form:
[0 1 0 0 0 0]
[1 2 0 0 0 0]
[0 0 2 3 0 0]
[0 0 3 4 0 0]
[0 0 0 0 4 5]
[0 0 0 0 5 6]
list form: [[1, 2, 1], [2, 1, 1], [2, 2, 2], [3, 3, 2], [3, 4, 3], [4, 3, 3], [4, 4, 4], [5, 5, 4], [5, 6, 5], [6, 5, 5], [6, 6, 6]]
```
Now we check for unresolved classes by evaluating `UnresolvedClasses(W,6,6,6)` which yields an output of `[]` indicating that $W$ is a resolving set. In fact, $W$ is a *minimum* resolving set by the lower bound in Theorem 2.2 of **cite paper**.

### Example 3
The dimensions do not all have to be the same. For example, consider a $5\times 7\times 11$ board whose cells are represented by tuples $(i,j,k)$ with $1\leq i\leq 5$, $1\leq j\leq 7$, and $1\leq k\leq 11$. If we evaluate
```
Wmatrix=matrix([[1,2,3,10,0,0,0],[4,5,6,1,2,3,0],[7,8,9,4,5,6,0],[10,0,0,7,8,9,0],[0,0,0,0,0,0,11]])
W=LatinRecToLandmarks(Wmatrix)
print("matrix form:")
print(Wmatrix)
print("unresolved classes:")
UnresolvedClasses(W,5,7,11)
```
we get an output of
```
matrix form:
[ 1  2  3 10  0  0  0]
[ 4  5  6  1  2  3  0]
[ 7  8  9  4  5  6  0]
[10  0  0  7  8  9  0]
[ 0  0  0  0  0  0 11]
number of landmarks: 21
unresolved classes:
[]
```
Thus $W$ is a size $21$ resolving set for the $5\times 7\times 11$ board. 

**Note:** If we want a faster test, we can run `IsResolvingQ(Wmatrix,11)`. This will output true or false, but in the case of false, it only reports on the first pair of unresolved vertices it finds.
