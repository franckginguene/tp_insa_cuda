#include <fstream>
#include <iostream>
#include <vector>
#include <chrono>
#include <string>
//
#include <cuComplex.h>
//
#define MaxIteration 255;  //!< Le nombre max d'itération est 255, soit de base le blanc.
//
static void HandleError(	cudaError_t err,
                            const char *file,
                            int line )
{
    if (err != cudaSuccess)
    {
        printf( "%s in %s at line %d\n", cudaGetErrorString( err ),
        file, line );
        exit( EXIT_FAILURE );
    }
}
#define HANDLE_ERROR( err ) (HandleError( err, __FILE__, __LINE__ ))
// Cette méthode sert uniquement à sauvegarder le vecteur sous forme d'une image en niveau de gris sur 8 bits.
void save_pgm(  const char*                         filename,
                const size_t                        width,
                const size_t                        height,
                const std::vector<std::uint8_t>&   data)
{
    std::ofstream fout{ filename };
    // L'en-tête
    fout << "P2\n" << width << " " << height << " 255\n";
    for (size_t row = 0; row < height; ++row)
    {
        for (size_t col = 0; col < width; ++col)
        {
            fout << (col ? " " : "")
                 << static_cast<unsigned>(data[row * width + col]);
        }
        fout << "\n";
    }
    fout.close();
}
//
__global__ void mandel_kernel_double(/* TODO */)
{
    // TODO : garder le même algorithme qu'en C++, il faut juste "traduire" les éléments
    // de C++ en CUDA.
    // Que devient la boucle 'for' si on souhaite calculer chaque pixel dans un thread ?
    // Attention à l'indice global du thread, il faut vérifier que nous sommes bien dans les bornes de l'image !
    // Utiliser les méthodes et les éléments fournis dans le PDF concernant les nombres complexes avec CUDA 
    // (on peut aussi explorer 'cuComplex.h' pour voir ce qui s'y trame).
}
//
int main(int argc, char* argv[])
{
    if (argc != 3)
    {
        std::cerr << "Usage:\n"
                  << argv[0] << " [width] [height]\n";
        return 1;
    }
    const size_t width  = std::stoul(argv[1]);
    const size_t height = std::stoul(argv[2]);
    std::vector<std::uint8_t> image(height * width, 0);
    // Note : il est possible de manipuler le pointeur de données sous-jacent au vecteur via la méthode '.data()'
    auto t0 = std::chrono::high_resolution_clock::now();
    // TODO : Appeler mandel_kernel_double
    auto t1 = std::chrono::high_resolution_clock::now();
    std::cout << "Generation of Mandelbrot set for image size " << width << " x " << height << " took "
              << std::chrono::duration<double>(t1-t0).count() << " seconds (GPU version)\n";
    save_pgm("output_GPU.pgm", width, height, image);
}
