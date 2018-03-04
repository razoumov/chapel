import cairocffi as cairo

ps = cairo.PDFSurface("domains.pdf",1000,500)
context = cairo.Context(ps)

context.set_dash([10.,0.])
context.set_line_width(2)
context.set_source_rgb(0.8,1,1)
context.rectangle(100,100,300,300); context.fill()
context.set_source_rgb(0,0,0)
context.rectangle(100,100,300,300); context.stroke()
for i in range(5):
    context.move_to(100,150+i*50); context.line_to(400,150+i*50); context.stroke()
    context.move_to(150+i*50,100); context.line_to(150+i*50,400); context.stroke()
context.set_dash([18.,23.])
context.set_source_rgb(0,0,1)
context.set_line_width(5)
for i in [2,4]:
    context.move_to(100+i*50,60); context.line_to(100+i*50,440); context.stroke()
for i in [2,4]:
    context.move_to(60,100+i*50); context.line_to(440,100+i*50); context.stroke()

context.set_dash([10.,0.])
context.set_line_width(2)
context.set_source_rgb(1,1,0.3)
context.rectangle(550,50,400,400); context.fill()

context.set_dash([10.,0.]);
context.set_line_width(8);
context.set_source_rgba(1,1,1,alpha=0.8)
context.rectangle(550,50,50,400); context.fill();
context.rectangle(900,50,50,400); context.fill()
context.rectangle(600,50,300,50); context.fill();
context.rectangle(600,400,300,50); context.fill()

context.set_source_rgb(0,0,0)
context.set_line_width(2)
context.rectangle(550,50,400,400); context.stroke()
for i in range(7):
    context.move_to(550,100+i*50); context.line_to(950,100+i*50); context.stroke()
    context.move_to(600+i*50,50); context.line_to(600+i*50,450); context.stroke()
context.set_dash([18.,23.])
context.set_source_rgb(0,0,1)
context.set_line_width(5)
for i in [2,4]:
    context.move_to(600+i*50,20); context.line_to(600+i*50,480); context.stroke()
for i in [2,4]:
    context.move_to(520,100+i*50); context.line_to(980,100+i*50); context.stroke()
