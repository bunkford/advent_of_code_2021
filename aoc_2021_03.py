data = [[int(j) for i in l for j in i] for l in list(open('aoc_2021_03.txt').read().split("\n"))]
count = [sum(i) for i in list(map(list, zip(*data)))] 
gamma = int("".join([str(i) for i in map(lambda x: 1 if (x > len(data)/2) else 0, count)]), 2)
epsilon = int("".join([str(i) for i in map(lambda x: 0 if (x > len(data)/2) else 1, count)]), 2)
print "Answer part 1: ", gamma * epsilon