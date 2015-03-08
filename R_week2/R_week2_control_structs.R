x <- c("h", "e", "l", "l", "o")

# length
lx <- length(x)
for (i in 1:lx) {
  print(x[i])
}

# ?seq_along
for (i in seq_along(x)) {
  print(x[i])
}

# direct iteration
for (c in x) {
  print(c)
}

# while
count <- 1
while (count < 6)
{
  print(x[count])
  count <- count + 1
}

# there is also repeat