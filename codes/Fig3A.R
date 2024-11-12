S <- readRDS("DGF_final_cell_type.RDS")

S@meta.data$Combined_Cell_Type <- factor(S@meta.data$Combined_Cell_Type, levels = rev(c("Podocytes", "Vasculature Endothelial", 
                                                                                        "Vascular Smooth Muscle", "Principal", 
                                                                                        "Intercalated", "Fibroblast", "Macrophage", 
                                                                                        "Proximal Tubule", "Distal Convoluted Tubule", 
                                                                                        "K1", "K2")))

Idents(S) <- "Combined_Cell_Type"

gene_order <- c("VEGFA", "PODXL", "PLVAP", "PECAM1", "MYH11", "ACTA2", "AQP3", "ADGRF5", "PTGER3", 
                "COL3A1", "COL1A2", "CD14", "C1QA", "GPX3", "ALDOB", "KNG1", "SPP1", "CD79A", "IGKC", 
                "MYL7", "PPP1R1B")

dotplot <- DotPlot(S, features = gene_order, group.by = "Combined_Cell_Type") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Gene Expression Across Combined Cell Types (Reversed Order)")

ggsave("cell_type_dotplot_DGF.png", plot = dotplot, width = 10, height = 8, dpi = 300)
