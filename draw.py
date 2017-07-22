import cairocffi as cairo
import math

ps = cairo.PDFSurface("domains.pdf",1100,500)
cr = cairo.Context(ps)

cr.set_dash([10.,0.])
cr.set_line_width(2)
cr.set_source_rgb(0.8,1,1)
cr.rectangle(100,100,300,300); cr.fill()
cr.set_source_rgb(0,0,0)
cr.rectangle(100,100,300,300); cr.stroke()
for i in range(5):
    cr.move_to(100,150+i*50); cr.line_to(400,150+i*50); cr.stroke()
    cr.move_to(150+i*50,100); cr.line_to(150+i*50,400); cr.stroke()
cr.set_dash([20.,23.])
cr.set_source_rgb(0,0,1)
cr.set_line_width(5)
for i in [2,4]:
    cr.move_to(100+i*50,20); cr.line_to(100+i*50,480); cr.stroke()
for i in [3]:
    cr.move_to(20,100+i*50); cr.line_to(480,100+i*50); cr.stroke()

cr.set_dash([10.,0.])
cr.set_line_width(2)
cr.set_source_rgb(1,1,0.8)
cr.rectangle(650,50,400,400); cr.fill()
cr.set_source_rgb(0,0,0)
cr.rectangle(650,50,400,400); cr.stroke()
for i in range(7):
    cr.move_to(650,100+i*50); cr.line_to(1050,100+i*50); cr.stroke()
    cr.move_to(700+i*50,50); cr.line_to(700+i*50,450); cr.stroke()
cr.set_dash([20.,23.])
cr.set_source_rgb(0,0,1)
cr.set_line_width(5)
for i in [2,4]:
    cr.move_to(700+i*50,20); cr.line_to(700+i*50,480); cr.stroke()
for i in [3]:
    cr.move_to(620,100+i*50); cr.line_to(1080,100+i*50); cr.stroke()
