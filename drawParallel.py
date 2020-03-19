import cairocffi as cairo
from math import pi

def write(x,y,string,size=20):
    context.set_font_size(size)
    context.move_to(x,y); context.show_text(string)

dx, dy, dy2 = 100, 20, 10
ps = cairo.PDFSurface("parallel.pdf",590,290)
context = cairo.Context(ps)

# context.rectangle(0, 0, 590, 290)
# context.set_source_rgb(0.199, 0.199, 0.199)
# context.fill()

context.set_source_rgb(0.2,0.2,0.8)
write(40+dx,100+dy,u'config var numtasks = 2;           ',size=12)
write(40+dx,115+dy,u'coforall taskid in 1..numtasks do  ',size=12)
write(40+dx,130+dy,u'    writeln("this is task ", taskid);',size=12)

context.set_source_rgb(0.2,0.2,0.8)
write(40+dx,205+dy2,u'var A, B, C: [1..1000] real;   ',size=12)
write(40+dx,220+dy2,u'forall (a,b,c) in zip(A,B,C) do',size=12)
write(40+dx,235+dy2,u'    c = a + b;                   ',size=12)

write(232+dx,100+dy,u'forall loc in Locales do                        ',size=12)
write(232+dx,115+dy,u'    on loc do                                     ',size=12)
write(232+dx,130+dy,u'        writeln("this locale is named ", here.name);',size=12)

context.set_source_rgb(0.2,0.2,0.8)
write(250+dx,190+dy2,u'use BlockDist;                       ',size=12)
write(250+dx,205+dy2,u'const mesh = {1..100,1..100} dmapped ',size=12)
write(250+dx,220+dy2,u'    Block(boundingBox={1..100,1..100});',size=12)
write(250+dx,235+dy2,u'var T: [mesh] real;                  ',size=12)
write(250+dx,250+dy2,u'forall (i,j) in T.domain do          ',size=12)
write(250+dx,265+dy2,u'    T[i,j] = i + j;                    ',size=12)

context.set_source_rgb(0,0,0)
write(10,130,u'task parallel',size=15)
write(10,220,u'data parallel',size=15)

write(160,35,u'single locale')
write(130,55,u'shared memory parallelism',size=15)

write(400,30,u'multiple locales')
write(360,50,u'distributed memory parallelism',size=15)
write(350,65,u'+ likely shared memory parallelism',size=15)

# context.set_source_rgba(0,0,1,alpha=0.8)
# context.rectangle(140,105,170,50); context.stroke()
# context.rectangle(350,190,200,90); context.stroke()

context.set_source_rgb(0.7,0.7,0.7)
context.set_line_width(1);
context.move_to(120,0); context.line_to(120,300); context.stroke()
context.move_to(323,0); context.line_to(323,300); context.stroke()
context.move_to(0,85); context.line_to(600,85); context.stroke()
context.move_to(0,175); context.line_to(600,175); context.stroke()
