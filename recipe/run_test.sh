mpmetis graphs/metis.mesh 10
gpmetis graphs/mdual.graph 10
ndmetis graphs/mdual.graph 10
gpmetis graphs/test.mgraph 10
m2gmetis graphs/metis.mesh 10

# Regression test for https://github.com/KarypisLab/METIS/issues/69
${CXX} -lmetis metis_test.cpp -o metis_test
./metis_test
