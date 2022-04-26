library('raster')
library('stringr')
library('ENMTools')

#carregar as variáveis ambientais usadas na modelagem
p_envs=list.files("/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/present/",pattern='.tif')
setwd('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/present/')
env <- stack(p_envs)
env <- setMinMax(env)
env <- check.env(env)


#####Pilosocereus arrabidae#####
#carregar raster de ocorrencia
r_arrab = raster('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/results/Pilosocereus_arrabidae.tif')
#carregar pontos de ocorrencia
d_arrab=read.csv('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/Pilosocereus_arrabidae.csv')
#criar um enmtools.species com raster e pontos de ocorrencia
arrab = enmtools.species(range=r_arrab, presence.points = d_arrab, species.name = "Pilosocereus arrabidae")

#####Pilosocereus_catingicola_catingicola#####
r_cat = raster('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/results/Pilosocereus_catingicola_catingicola.tif')
d_cat=read.csv('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/Pilosocereus_catingicola_catingicola.csv')
cat = enmtools.species(range=r_cat, presence.points = d_cat, species.name = "Pilosocereus catingicola catingicola")

#####Pilosocereus_catingicola_salvadorensis#####
r_sal = raster('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/results/Pilosocereus_catingicola_salvadorensis.tif')
d_sal=read.csv('/home/eduardo/Documents/projetos/cactos_nicho_estabilidade/Pilosocereus_catingicola_salvadorensis.csv')
cat = enmtools.species(range=r_sal, presence.points = d_sal, species.name = "Pilosocereus catingicola salvadorensis")


#niche overlap
raster.overlap(r_arrab, r_cat)
#Range Braking
rbl.glm <- rangebreak.linear(arrab, cat, env, type = "glm", nreps = 4)
#niche identity
id<-identity.test(species.1 = arrab, species.2 = cat, env = env, type = "glm", nreps = 4)
#Background identity
bg <- background.test(species.1 = arrab, species.2 = cat, env = env, type = "bc", nreps = 4, test.type = "asymmetric" )


