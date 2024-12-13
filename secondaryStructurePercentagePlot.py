# Percentage of secondary structure over the course of the simulation
import sys
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
#name = input("File name:") ##if you desire to request input
#ext = ".txt"
#name = sys.argv[1]
name = "secondarystructureFileFromVMD.txt"
FO = name + "Analysis.dat"
#fileName = name + ext
plotName = name, ".eps"
f = open(name, "r")
fOut = open(FO, "w")
a = 1
t = 0
e = 0
b = 0
h = 0
g = 0
i = 0
c = 0
counter = 0
line: str
for x in f: #loop that navigates the entire file and classifies type of motif
    line = x.split(" ")[4]
    if line == "T\n":
        t = t + 1
    elif line == "E\n":
        e = e + 1
    elif line == "B\n":
        b = b + 1
    elif line == "H\n":
        h = h + 1
    elif line == "G\n":
        g = g + 1
    elif line == "I\n":
        i = i + 1
    elif line == "C\n":
        c = c + 1
    counter = counter + 1
print(counter)
t = t/counter*100
tt = "{:.2f}".format(t)
fOut.write('Motifs\n')
fOut.write("T = % " + tt + '\n')
e = e/counter*100
ee = "{:.2f}".format(e)
fOut.write("E = % " + ee + '\n')
b = b/counter*100
bb = "{:.2f}".format(b)
fOut.write("B = % " + bb + '\n')
h = h/counter*100
hh = "{:.2f}".format(h)
fOut.write("H = % " + hh + '\n')
g = g/counter*100
gg = "{:.2f}".format(g)
fOut.write("G = % " + gg + '\n')
i = i/counter*100
ii = "{:.2f}".format(i)
fOut.write("I = % " + ii + '\n')
c = c/counter*100
cc = "{:.2f}".format(c)
fOut.write("C = % " + cc + '\n')
fOut.close()
f.close()

labels = 'Turn (T)', 'Extended Beta Sheet (E)', 'Beta Sheet Bridge (B)', 'Alpha Helix (H)', '3-10 Helix (G)', \
    'Pi-helix (I)', 'Coil (C)\n(no structure)'
sizes = [tt, ee, bb, hh, gg, ii, cc]
fig, ax = plt.subplots()
ax.pie(sizes, colors=['LightSeaGreen', 'orange', 'olive', 'DeepPink', 'blue', 'red', 'lightslategrey'], shadow = True,
       wedgeprops={"edgecolor": "black",
                   'linewidth': 0.5,
                   'antialiased': True}
       )

#plt.legend( labels=labels, title= "Motifs", loc="upper right", bbox_to_anchor=(1, 0, 0.5, 1))
#plt.subplots_adjust(left=0.1, bottom=0.1, right=0.75)
plt.savefig(name + '.eps', format='eps')
plt.show()
