#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int size, row, column, space;
    do
    {
        size = get_int("Height Size: ");
    }
    while (size < 1 || size > 8);

    for (row = 0; row < size; row++)
    {
        for (space = 0; space < size - row - 1; space++)
        {
            printf(" ");
        }
        for (column = 0; column <= row; column++)
        {
            printf("#");
        }
        printf("\n");
    }
}