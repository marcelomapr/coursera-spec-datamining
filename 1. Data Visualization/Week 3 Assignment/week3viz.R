library(igraph)

fname <- 'lesmis.gml'

g <- read.graph(fname, format=c("gml"))

selected_vertex <- vertex_attr(g)$label %in% c('Valjean', 'Cosette', 'Javert', 'Fantine', 'Pontmercy', 
                            'Myriel', 'Thenardier', 'Eponine', 'Gillenormand', 
                            'Gavroche', 'Enjolras', 'Fauchelevent', 'Gervais',
                            'Champmathieu', 'Mabeuf', 'MmePontmercy', 'Tholomyes',
                            'Azelma')
g2 <- igraph::induced_subgraph(g, selected_vertex)
V(g2)$vertex_degree <- 4*degree(g2)

set.seed(1492) 

l <- layout.fruchterman.reingold(g2, niter=5000, area=vcount(g2)^4*10)

png('lesmiserables_network.png')

plot(g2, 
     layout = l,
     vertex.size = V(g2)$vertex_degree,
     main = 'Les Miserables Main Character Connections', vertex.label.cex = 0.8,
     edge.arrow.size=0.5, 
     vertex.label.cex=0.75, 
     vertex.label.family="Helvetica",
     vertex.label.font=2,
     vertex.shape="circle", 
     vertex.label.color="black", 
     edge.width=0.5
)
dev.off()
