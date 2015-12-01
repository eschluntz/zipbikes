import time
from math import floor

lump = 3000;
secret = "super_secret_password"

t = floor(time.time() / lump) * lump

ul_max = 2**32

# start off hash with time
code = int(t)
for c in secret:
	code = ((code << int(5))% ul_max + code + ord(c))% ul_max

print str(code)