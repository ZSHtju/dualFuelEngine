#!/bin/bash
#------------------------------------------------------------------------------
# =========                 |
# \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
#  \\    /   O peration     | Website:  https://github.com/StasF1
#   \\  /    A nd           | Copyright (C) 2017 OpenFOAM Foundation
#    \\/     M anipulation  |
#------------------------------------------------------------------------------
# Script
#     AllRerun
#
# Description
#     Generates mesh and run all cases using the multiCompression solver
#
#------------------------------------------------------------------------------

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * #

cd ${0%/*} || exit 1 # Run from this directory

startProjectTime=`date +%s` # Включение секундомера для вывода времени расчёта

# Масштабирование файлов .stl
cd geometry
./Allclean && ./Allrun
printf '\n'

# Построение сетки
cd ../mesh
./Allclean && ./Allrun
printf '\n'

# Решение проекта на собственном ядре
cd ../case
./Allclean && ./Allrun
printf '\n'

# Решение проекта для сравнения результатов c potentialFoam'ом
cd ../casePotential
./Allclean && ./Allrun
printf '\n'

# Решение проекта для сравнения результатов со scalarTransportFoam'ом
cd ../caseScalar
./Allclean && ./Allrun
printf '\n'

# Отображение времени расчёта проекта
cd ../
endProjectTime=`date +%s`
solveProjectTime=$((endProjectTime-startProjectTime))
printf 'Calculation time: %dh:%dm:%ds\n'\
	 $(($solveProjectTime/3600)) $(($solveProjectTime%3600/60)) $(($solveProjectTime%60))

echo -ne '\007' # звуковой сигнал
# ***************************************************************************** #