#include "helpers.h"
#include "math.h"

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int row = 0; row < height; row++)
    {
        for (int col = 0; col < width; col++)
        {
            int avg = round((image[row][col].rgbtBlue + image[row][col].rgbtGreen + image[row][col].rgbtRed) / 3.0);
            image[row][col].rgbtBlue = image[row][col].rgbtGreen = image[row][col].rgbtRed = avg;
        }
    }
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int row = 0; row < height; row++)
    {
        for (int col = 0; col < width; col++)
        {
            int sRed = image[row][col].rgbtRed;
            int sGreen = image[row][col].rgbtGreen;
            int sBlue = image[row][col].rgbtBlue;

            image[row][col].rgbtRed = fmin(255, (int) (0.393 * sRed + 0.769 * sGreen + 0.189 * sBlue + 0.5));
            image[row][col].rgbtGreen = fmin(255, (int) (0.349 * sRed + 0.686 * sGreen + 0.168 * sBlue + 0.5));
            image[row][col].rgbtBlue = fmin(255, (int) (0.272 * sRed + 0.534 * sGreen + 0.131 * sBlue + 0.5));
        }
    }
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

    for (int row = 0; row < height; row++)
    {
        for (int col = 0; col < width; col++)
        {
            temp[row][col] = image[row][col];
        }
    }

    for (int row = 0; row < height; row++)
    {
        for (int col = 0, swap = width - 1; col < width; col++)
        {
            image[row][col] = temp[row][swap];
            swap--;
        }
    }
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

    for (int row = 0; row < height; row++)
    {
        for (int col = 0; col < width; col++)
        {
            temp[row][col] = image[row][col];
        }
    }

    float totalred, totalgreen, totalblue;
    int count = 0;
    totalred = totalgreen = totalblue = 0;

    for (int row = 0; row < height; row++)
    {
        for (int col = 0; col < width; col++)
        {
            for (int arrrow = row - 1; arrrow <= row + 1; arrrow++)
            {
                for (int arrcol = col - 1; arrcol <= col + 1; arrcol++)
                {
                    if (arrcol < width && arrrow < height && arrcol >= 0 && arrrow >= 0)
                    {
                        totalred += temp[arrrow][arrcol].rgbtRed;
                        totalgreen += temp[arrrow][arrcol].rgbtGreen;
                        totalblue += temp[arrrow][arrcol].rgbtBlue;
                        count++;
                    }
                }
            }
            image[row][col].rgbtRed = round(totalred / count);
            image[row][col].rgbtGreen = round(totalgreen / count);
            image[row][col].rgbtBlue = round(totalblue / count);
            count = 0;
            totalred = totalgreen = totalblue = 0;
        }
    }
    return;
}
