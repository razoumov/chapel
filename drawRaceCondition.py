import cairocffi as cairo
from math import pi

def write(x,y,string,size=20):
    context.set_font_size(size)
    context.move_to(x,y); context.show_text(string)

dx, dy = -30, -70
ps = cairo.PDFSurface("raceCondition.pdf",430,450)
context = cairo.Context(ps)

write(50+dx, 100+dy, u'lock.add(1)')
write(50+dx, 125+dy, u'lock.waitFor(2)')
write(50+dx, 225+dy, u'"task 1 is done"')
write(50+dx, 250+dy, u'lock.sub(1)')
write(50+dx, 275+dy, u'lock.waitFor(0)')

write(300+dx, 225+dy, u'lock.add(1)')
write(300+dx, 250+dy, u'lock.waitFor(2)')

for i in range(3):
    context.arc(350+dx, 100+40*i+dy, 3, 0, 2*pi)   # draw circles
    context.fill(); context.stroke()

context.move_to(100+dx,140+dy); context.line_to(100+dx,200+dy); context.stroke()   # vertical line
for i in range(2):
    context.move_to(100+dx,200+dy); context.line_to(97+i*6+dx,182+dy); context.stroke()   # arrow tip

context.move_to(100+dx,295+dy); context.line_to(100+dx,450+dy); context.stroke()   # vertical line
for i in range(2):
    context.move_to(100+dx,450+dy); context.line_to(97+i*6+dx,432+dy); context.stroke()   # arrow tip

context.move_to(350+dx,270+dy); context.line_to(350+dx,450+dy); context.stroke()   # vertical line
for i in range(2):
    context.move_to(350+dx,450+dy); context.line_to(347+i*6+dx,432+dy); context.stroke()   # arrow tip

context.set_source_rgba(0,0,1,alpha=0.8)
write(45,440,u'Note: lock.waitFor() is not a collective operation',size=15)

context.set_source_rgba(1,1,0,alpha=0.5)
context.rectangle(40+dx,230+dy,400,25); context.fill()
