length = 4;

ans = ""
for i in range(0, length):
    for j in range(0, length):
        for k in range(0, length): 
            for l in range (0, length):
                for m in range (0, length):
                    for n in range (0, length):
                        for o in range (0, length):
                            ans += str(i) + ", " + str(j) + ", " + str(k) + ", " + str(l) + ", " + str(m) + ", " + str(n) + ", " + str(o) + "\n"
                            
print ans
