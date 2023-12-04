int teste() 
{
    int a, b;
    a = 11;
    b = 5;
    while (a > b) {
        if (b < 10)
            b = b + b;
    }

    aiai(b);
}

int aiai(int b){
    println(b);
}

