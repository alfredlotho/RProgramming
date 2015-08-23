#The functions below are used to create a special matrix whose cache is stored in memory
#so that it doesn't have to be computed everytime if the matrix does not change

#The function below defines internal functions to store and retrieve the inverse matrix 
#of the input argument matrix. The assumption is that the matrix is always invertible
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  } 
  get <- function() x
  setinverse <- function(inv) i <<- inv
  getinverse <- function() i
  list(set=set, get=get,
       setinverse = setinverse,
       getinverse = getinverse)
}

#The function below computes the cache of a matrix using the solve function
#If it has already been previously computed, the value is taken from cache
#Otherwise. it is computed and saved to cache
cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}