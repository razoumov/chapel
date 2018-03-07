import cairocffi as cairo
from math import pi

def write(x,y,string,size=20):
    context.set_font_size(size)
    context.move_to(x,y); context.show_text(string)
    
ps = cairo.PDFSurface("orthogonal.pdf",800,500)
context = cairo.Context(ps)

context.set_source_rgb(0,0,1)
for i in range(3):
    for j in range(2):
        if (i,j) == (0,1) or (i,j) == (1,0) or (i,j) == (2,0):
            radius = 20
        elif (i,j) == (0,0):
            radius = 0
        else:
            radius = 10
        context.arc(150+i*160, 160+j*190, radius, 0, 2*pi)   # draw circles
        context.fill(); context.stroke()

write(125, 380, u'serial local', size=10)
write(285, 190, u'parallel local', size=10)
write(430, 190, u'parallel distributed', size=10)

context.set_source_rgb(0.6,0.6,0.6)
context.set_line_width(2)
context.move_to(70,450); context.line_to(70,50); context.stroke()   # vertical axis
for i in range(2):
    context.move_to(70,50); context.line_to(67+i*6,68); context.stroke()   # arrow tip
context.move_to(70,450); context.line_to(700,450); context.stroke()   # horizontal axis
for i in range(2):
    context.move_to(700,450); context.line_to(682,447+i*6); context.stroke()   # arrow tip
write(40, 30, u'parallelism')
write(720, 455, u'locality')

context.set_source_rgb(0,0,0.5)
write(400, 30, u'Consider a set of tasks', size=30)
write(400, 65, u'   that we want to run', size=30)

context.set_source_rgb(0,0,0)
write(100, 480, u'single core')
write(260, 470, u'several cores')
write(260, 490, u'  single node')
write(420, 470, u'  many cores')
write(420, 490, u'multiple nodes')

context.set_source_rgb(0.6,0,0)
write(590, 275-60, u'Also DATA LOCALITY:', size=18)
write(590, 300-60, u'each of these tasks', size=18)
write(590, 325-60, u'could be using variables', size=18)
write(590, 350-60, u' - in local memory or', size=18)
write(590, 375-60, u' - in memory on other', size=18)
write(590, 400-60, u'     compute nodes', size=18)

context.set_source_rgb(0,0,0)
context.rotate(-pi/2)
write(-380, 50, u'serial')
write(-200, 50, u'parallel')
