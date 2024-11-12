S <- readRDS("DGF_final_cell_type.RDS")

S@meta.data$Combined_Cell_Type <- factor(S@meta.data$Combined_Cell_Type, levels = rev(c("Proximal Tubule 1", "Proximal Tubule 2", 
                                                                                        "Proximal Tubule 3")))
Idents(S) <- "Cell_type"

gene_order <- c("A1BG", "FAP", "NEAT1", "SRSF5", "CD300E", "CCL23")

dotplot <- DotPlot(S, features = gene_order, group.by = "Cell_type") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("PT Subgroups Gene Expression")

ggsave("PT_dotplot_DGF.png", plot = dotplot, width = 10, height = 8, dpi = 300)

S@meta.data$Combined_Cell_Type <- factor(S@meta.data$Combined_Cell_Type, levels = rev(c("Distal Convoluted Tubule 1", "Distal Convoluted Tubule 2", 
                                                                                        "Distal Convoluted Tubule 3")))
Idents(S) <- "Cell_type"

gene_order <- c("CALB1", "TMSB4X", "PTK2", "NEAT1", "VSNL1", "TLR1")

dotplot <- DotPlot(S, features = gene_order, group.by = "Cell_type") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("DCT Subgroups Gene Expression")

ggsave("DCT_dotplot_DGF.png", plot = dotplot, width = 10, height = 8, dpi = 300)





