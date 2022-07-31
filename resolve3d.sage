################################################################################
# resolve3d.sage
# Briana Foster-Greenwood
# Last update: 29 July 2022
#
# This Sage code is for testing whether a set of vertices resolves the
# generalized Hamming graph HG(n1,n2,n3;3) for n_i\geq 3.
#
# Run at https://sagecell.sagemath.org/
#
# See README.md at https://github.com/fostergreenwood/metric-dimension
# for further background and examples of how to run the code.


################################################################################
#                            LATIN REC TO LANDMARKS
# Input:  2-dimensional array latmat
# 
# Output: list of [i,j,k] where symbol k appears 
#         in row i, column j of latmat; zeros in 
#         latmat are ignored
#-------------------------------------------------------------------------------
def LatinRecToLandmarks(latmat):
    W=[]
    numrows=len(latmat)            # len gets the length of a list
    numcols=len(latmat[0])
    for i in [1..numrows]:
        for j in [1..numcols]:
            if latmat[i-1][j-1]>0: # -1 is because Sage indexes from 0
                W.append([i,j,latmat[i-1][j-1]]) 
    return W

################################################################################
#                              HAMMING VERTEX SET
# Input:  three natural numbers n1,n2,n3
# 
# Output: list of [i,j,k] where i in [1..n1], 
#         j in [1..n2], and k in [1..n3]
#-------------------------------------------------------------------------------
def HammingVertexSet(n1,n2,n3):
    V=[]
    for i in [1..n1]:
        for j in [1..n2]:
            for k in [1..n3]:
                V.append([i,j,k])
    return V

################################################################################
#                               HAMMING DISTANCE
# Input:  two elements x and y of a 3d Hamming vertex set
# 
# Output: number of coordinates where x and y differ
#-------------------------------------------------------------------------------
def HammingDistance(x,y):
    d=0
    for i in range(3):
        if x[i]!= y[i]:
            d=d+1
    return d

################################################################################
#                         GENERALIZED HAMMING DISTANCE
# Input:  two elements x and y of a 3d Hamming vertex set
# 
# Output: distance between x and y in generalized Hamming graph HG(n1,n2,n3;3)
#-------------------------------------------------------------------------------
def GraphDistance(x,y):
    hd=HammingDistance(x,y)
    if hd==3:
        return 1    # vertices are adjacent if they have no coordinate in common
    elif hd==2 or hd==1:
        return 2    # vertices are two away if they have 1 or 2 coordinates in common
    else:
        return 0    # vertices are the same if they have all coordinates in common

################################################################################
#                               LOCATION VECTOR
# Input:  an element x of a Hamming vertex set
#         and a list W that is a subset of the Hamming vertex set
# 
# Output: a list of distances from x to w in the graph HG(n1,n2,n3;3)
#-------------------------------------------------------------------------------
def LocationVector(x,W):
    locvec=[]
    for w in W:
        locvec.append(GraphDistance(x,w))
    return locvec

################################################################################
#                            UNRESOLVED CLASSES
# Input:  a list W of some elements of a Hamming vertex set
#         and positive integers n1, n2, n3 for the size of
#         the board
# 
# Output: a list of lists of elements that are not resolved by W
#-------------------------------------------------------------------------------
def UnresolvedClasses(W,n1,n2,n3):
    classes=[]     # to store lists of elements with the same location vector
    V=HammingVertexSet(n1,n2,n3)
    locationVecs=[LocationVector(x,W) for x in V]
    distinctLocationVecs=[]
    for loc in locationVecs:
        if loc not in distinctLocationVecs:
            distinctLocationVecs.append(loc)
            classes.append([x for x in V if LocationVector(x,W)==loc])
    unresolvedClasses=[c for c in classes if len(c)>1]
    return unresolvedClasses

################################################################################
#                                 RESOLVED Q
# Input:  a list W of some elements of a Hamming vertex set
#         and two elements x and y of the Hamming vertex set
# 
# Output: true if x and y are resolved by some element of W, false otherwise
#-------------------------------------------------------------------------------
def ResolvedQ(W,x,y):
    if x!=y:
        for w in W:
            if GraphDistance(x,w)!=GraphDistance(y,w):
                return true  # x and y are resolved by w
        return false  # never encountered a w that resolves x and y
    else:   # x==y
        return true

################################################################################
#                               IS RESOLVING Q
# Input:  a list W of some elements of a Hamming vertex set
#         and the dimensions n1,n2,n3 of the board
# 
# Output: true if W resolves the board, false otherwise;
#         in the case of false, the function also prints the 
#         first unresolved pair found
#-------------------------------------------------------------------------------
def IsResolvingQ(W,n1,n2,n3):
    V=HammingVertexSet(n1,n2,n3)
    for x in V:
        for y in V:
            if x not in W and y not in W and x!=y and not ResolvedQ(W,x,y):
                print("found unresolved pair:",x,"and",y)
                return false  # unresolved pair was found
    return true # unresolved pair was never encountered

################################################################################
#                                 EXAMPLES
# remove the comment tags # from the code for the example you want to run
# or create your own example!
#-------------------------------- Example 1a -----------------------------------
#W=[[1,1,1],[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
#print("unresolved classes:")
#UnresolvedClasses(W,3,3,3)
#---------------------------------Example 1b -----------------------------------
#W=[[1,2,2],[1,3,3],[2,2,1],[2,3,2],[2,1,3]]
#print("unresolved classes:")
#UnresolvedClasses(W,3,3,3)
#--------------------------------- Example 2 -----------------------------------
#Wmat=[[0,1,0,0,0,0],[1,2,0,0,0,0],[0,0,2,3,0,0],[0,0,3,4,0,0],[0,0,0,0,4,5],[0,0,0,0,5,6]]
#W=LatinRecToLandmarks(Wmat)
#print("matrix form:")
#print(matrix(Wmat))
#print("list form:",W)
#print("number of landmarks:",len(W))
#print("unresolved classes:")
#UnresolvedClasses(W,6,6,6)
#---------------------------------- Example 3 ----------------------------------
#Wmat=[[1,2,3,10,0,0,0],[4,5,6,1,2,3,0],[7,8,9,4,5,6,0],[10,0,0,7,8,9,0],[0,0,0,0,0,0,11]]
#W=LatinRecToLandmarks(Wmat)
#print("matrix form:")
#print(matrix(Wmat))
#print("number of landmarks",len(W))
#print("resolving?")
#print(IsResolvingQ(W,5,7,11))
#print("unresolved classes:")
#UnresolvedClasses(W,5,7,11)
