DGF <- readRDS("DGF_harmonyByPatient.RDS")

DGF <- subset(DGF, subset = nFeature_RNA >50 & nFeature_RNA < 1100)
DGF <- NormalizeData(DGF, normalization.method = "LogNormalize", scale.factor = 10000)

stim_features <- split(row.names(DGF@meta.data), DGF@meta.data$stim) %>%
  lapply(function(cells_use) {
    DGF[, cells_use] %>%
      FindVariableFeatures(selection.method = "vst", nfeatures = 2000) %>%
      VariableFeatures()
  }) %>%
  unlist %>%
  unique

patient_features <- split(row.names(DGF@meta.data), DGF@meta.data$Patient) %>%
  lapply(function(cells_use) {
    DGF[, cells_use] %>%
      FindVariableFeatures(selection.method = "vst", nfeatures = 2000) %>%
      VariableFeatures()
  }) %>%
  unlist %>%
  unique

VariableFeatures(DGF) <- union(stim_features, patient_features)

DGF <- DGF %>% 
  ScaleData(verbose = FALSE) %>% 
  RunPCA(features = VariableFeatures(DGF), npcs = 30, verbose = FALSE) 

DGF <- DGF %>% 
  RunHarmony(c("stim", "Patient"), plot_convergence = TRUE, nclust = 50, sigma = 0.1, theta = c(3, 3), max_iter = 10, early_stop = F)

DGF <- FindNeighbors(DGF,reduction = "harmony", dims = 1:30)
DGF <- FindClusters(DGF, resolution = 1, algorithm = 4, method = "igraph")
DGF <- RunUMAP(DGF, reduction = "harmony", dims = 1:30)
DimPlot(DGF, reduction = "umap", group.by = "Condition", label = TRUE, pt.size = 0.01, raster = "FALSE")
