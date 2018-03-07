import cairocffi as cairo

ps = cairo.PDFSurface("decomposition.pdf",520,520)
context = cairo.Context(ps)

context.set_dash([10.,0.])
context.set_line_width(1)
context.set_source_rgb(0.8,1,1)
context.rectangle(10,10,500,500); context.fill()
context.set_source_rgb(0,0,0)
context.rectangle(10,10,500,500); context.stroke()
for i in range(99):
    context.move_to(10,15+i*5); context.line_to(510,15+i*5); context.stroke()
for i in range(99):
    context.move_to(15+i*5,10); context.line_to(15+i*5,510); context.stroke()
# context.set_dash([18.,23.])
context.set_source_rgb(0,0,1)
context.set_line_width(3)
for i in [24,49,74]:
    context.move_to(15+i*5,10); context.line_to(15+i*5,510); context.stroke()
for i in [32,65]:
    context.move_to(10,15+i*5); context.line_to(510,15+i*5); context.stroke()
