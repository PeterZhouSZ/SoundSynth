ROOT=ABSPATH_TO_PROJECT_FOLDER
LIBPATH=$ROOT/pre_compute/external/fmmlib3d-1.2/matlab

SOURCEPATH=${ROOT}/pre_compute/scripts
DATASET_NAME=final100

python ${SOURCEPATH}/Pre_Calc_EV.py $1 $2 0
cd $SOURCEPATH
CURPATH=${ROOT}/data/${DATASET_NAME}/$1/models/mat-$2
FILEGENERATORS=${ROOT}/file_generators
matlab -nodisplay -nodesktop -nosplash -r "addpath('${FILEGENERATORS}');addpath('${SOURCEPATH}');addpath('${LIBPATH}'); FMMsolver('$CURPATH',0); quit"

cd $CURPATH
mkdir -p moments
cd moments
if [ -f "moments.pbuf" ]
then
    echo "FOUND!!!"
else
    GENMOMENTS=${ROOT}/modal_sound/build/bin/gen_moments
    ${GENMOMENTS} ../fastbem/input-%d.dat ../bem_result/output-%d.dat 0 59
fi
