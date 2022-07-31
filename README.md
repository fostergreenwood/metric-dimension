# Metric Dimension

This repository contains code that accompanies the preprint 

[insert bib]

In particular, the code can be used to verify examples of resolving sets for generalized Hamming graphs $HG(n_1,n_2,n_3;3)$.

## Background

### The puzzle

We begin with the puzzle from the introduction of the article:

> Consider an $m\times n$ chessboard with some cells occupied by **landmarks**. A landmark in cell $(i,j)$ **sees** all other cells that are in row $i$ or column $j$. Is it possible to place landmarks on the board so that each unoccupied cell is seen by a different (possibly empty) set of landmarks? What is the minimum number of landmarks required? What if the puzzle is played in higher dimensions on an $n_1\times \cdots\times n_r$ board, where a landmark  sees all other cells that share at least one coordinate with the landmark's cell?

### Exploring the puzzle with Sage

The code in this repository is for exploring possible solutions to the puzzle on a $3$-dimensional board. The set of cells of an $n_1\times n_2\times n_3$ board is the set $V$ consisting of all tuples $(a_1,a_2,a_3)$ with $1\leq a_i\leq n_i$. A possible solution, or placement of landmarks, is denoted $W\subseteq V$. If every unoccupied cell is seen by a different set of landmarks, we say that $W$ **resolves** the board.

### Mathematics of the puzzle

What does all this have to do with metric dimension? When the $n_i$'s are all greater than or equal to $3$, resolving the board is equivalent to resolving a generalized Hamming graph. The cells of the board correspond to vertices of the graph. The minimum size of a resolving set is the metric dimension of the graph. We refer the reader to the article for the relevant definitions and a detailed explanation of the relationship between the puzzle, metric dimension, and generalized Hamming graphs.

## Running the code

The code is written in Sage. The simplest way to run the code is by copy-pasting the contents of `resolve3d.sage` into [SageMathCell](https://sagecell.sagemath.org/). You can also use Sage in [CoCalc](https://cocalc.com/) or install [SageMath](https://www.sagemath.org/) on your computer. 

**To run the code in SageMathCell** (easy-to-use web interface, no download or account needed):
1. Copy-paste the contents of `resolve3d.sage` into [SageMathCell](https://sagecell.sagemath.org/).
2. Now you are ready to try examples such as those shown below! Type the input and press Evaluate to see the output.

**To run the code from a terminal in CoCalc** (free trial available, runs faster with a low monthly licensing fee):
1. Start a new project (and make sure it is running!) in [CoCalc](https://cocalc.com/)
2. Upload `resolve3d.sage` to your project files.
3. Start a new terminal and type `sage`
4. At the `sage:` prompt, type `load("resolve3d.sage")` and press enter
5. Now you are ready to try examples such as those shown below! Type the input at the `sage:` prompt and press enter to see the output.

**To run the code from a Sage worksheet in CoCalc**:
1. Start a new project (and make sure it is running!).[CoCalc](https://cocalc.com/)
2. Upload `resolve3d.sage` to your project.
3. Start a new Sage worksheet
4. Type `attach("resolve3d.sage")` and run the cell.
5. Now you are ready to try examples such as those shown below! Type the input and run the cell to see the output.

## Examples

### Example 1

Consider a $3\times 3\times 3$ board whose $27$ cells are represented by tuples $(i,j,k)$ with $1\leq i,j,k\leq 3$. 

#### A resolving set
We can enter a candidate $W$ as a list of tuples `[i,j,k]` and check which pairs of vertices are unresolved. For example, if we evaluate

```
W=[[1,1,1],[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
print("unresolved classes:")
UnresolvedClasses(W,3,3,3)
```
we get an ouput of
```
unresolved classes: []
```
Since we got an empty list `[]`, the set $W$ resolves the board. 

#### A nonresolving set
In contrast, if we remove `[1,1,1]` from the set and evaluate
```
W=[[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
print("unresolved classes:")
UnresolvedClasses(W,3,3,3)
```
we get an output of
```
unresolved classes:
[[[1, 1, 1], [1, 2, 3], [3, 2, 3]],
 [[1, 3, 2], [3, 3, 2]],
 [[2, 1, 2], [2, 2, 2]],
 [[2, 3, 1], [2, 3, 3]]]
 ```
This means there are four classes of unresolved vertices. Consider the last class, `[[2,3,1],[2,3,3]]`. If we compare `[2,3,1]` with the landmarks in `W=[[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]`, we see that it has a coordinate in common with all except for the first landmark. Similarly, `[2,3,3]` has a coordinate in common with all except the first landmark. So `[2,3,1]` and `[2,3,3]` are unresolved because they are seen by the same set of landmarks. Thus, this choice of $W$ is not a resolving set.

### Example 2

Consider a $6\times 6\times 6$ board whose $216$ cells are represented by tuples $(i,j,k)$ with $1\leq i,j,k\leq 6$. This time, we will enter a set $W$ as a matrix, where symbol $k$ in row $i$, column $j$ corresponds to landmark $(i,j,k)$. Values of $k=0$ are ignored. We can then use the `LatinRecToLandmarks` function to convert the matrix to a list of tuples. For example, evaluating
```
Wmatrix=[[0,1,0,0,0,0],[1,2,0,0,0,0],[0,0,2,3,0,0],[0,0,3,4,0,0],[0,0,0,0,4,5],[0,0,0,0,5,6]]
W=LatinRecToLandmarks(Wmatrix)
print("matrix form:",matrix(Wmatrix))
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
The dimensions do not all have to be the same. For example, consider a $5\times 7\times 11$ board whose cells are represented by tuples $(i,j,k)$ with $1\leq i\leq 5$, $1\leq j\leq 7$, and $1\leq k\leq 11$. 

#### A resolving set
If we evaluate
```
Wmatrix=[[1,2,3,10,0,0,0],[4,5,6,1,2,3,0],[7,8,9,4,5,6,0],[10,0,0,7,8,9,0],[0,0,0,0,0,0,11]]
W=LatinRecToLandmarks(Wmatrix)
print("matrix form:")
print(matrix(Wmatrix))
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

Already, this example is large enough for the code to run noticeably slower. If we want a faster test, we can run `IsResolvingQ(W,5,7,11)`, which returns `true` in a little less time than it takes to sort into classes. 

#### A nonresolving set
If we run `IsResolvingQ` on a set that is not resolving, the function returns `false` as soon as it encounters an unresolved pair, rather than completely sorting all the vertices into classes. For example, when we evaluate
```
Wmatrix=[[1,0,3,10,0,0,0],[4,5,6,1,2,3,0],[7,8,9,4,5,6,0],[10,0,0,7,8,9,0],[0,0,0,0,0,0,11]]
W=LatinRecToLandmarks(Wmatrix)
print("matrix form:")
print(matrix(Wmatrix))
print("resolving?")
IsResolvingQ(W,5,7,11)
```
we fairly quickly get an output of
```
matrix form:
[ 1  0  3 10  0  0  0]
[ 4  5  6  1  2  3  0]
[ 7  8  9  4  5  6  0]
[10  0  0  7  8  9  0]
[ 0  0  0  0  0  0 11]
resolving?
found unresolved pair: [2, 1, 1] and [2, 1, 2]
False
```
so this choice of $W$ is not a resolving set.
