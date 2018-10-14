##### В README *_вкрате_* буду описывать, какие измениния сделал и зачем. Также буду это дублировать в статусе проекта в Асане.

# quadPiston
## mesh

В словаре _snappyHexMeshDict_ при удалении любых настроек выдаётся блок _blockMesh_'a. При выставлении параметров: `castellatedMesh true;` (line 19) - тоже.

В итоге, все настройки измельчения выставлены в _0_ - т.е. фактически измельчения нет.

## case

Путём копирования файлов результата расчёта (_U_ и _phi_) в создаваемую папку 1 (скриптами прводящими расчёт) удалось добиться возможности отображения результатов расчёта открытием файла _solved.foam_, только поскольку давление _potentialFoam_ не пишет, оно и не отображается (в отличие от `VTK/`_case_0.vtk_).

# multicompCompressFluid

Просмотрел код решателя, вроде и всё ясно, а вроде и ничего. Довольно замысловатый синтаксис, особанно после MATLAB'a.
Но просмотрев код понял, почему не открывался _solved.foam_ - решатель стационарный и решение создаёт независимо от времени, а для _solved.foam_ нужны как минумум ещё одна папка, кроме 0. 