float3 Turbo(float x)
{
    const float3x4 M1 =
      float3x4(0.13572138,  4.61539260, -42.66032258, 132.13108234,
               0.09140261,  2.19418839,   4.84296658, -14.18503333,
               0.10667330, 12.64194608, -60.58204836, 110.36276771);

    const float3x2 M2 =
      float3x2(-152.94239396, 59.28637943,
                  4.27729857,  2.82956604,
                -89.90310912, 27.34824973);

    float4 v = float4(1, x, x * x, x * x * x);
    return mul(M1, v) + mul(M2, v.zw * v.z); 
}

float Mandelbrot(float2 coord)
{
    float2 z = 0;

    for (uint itr = 0; itr < 100; itr++)
    {
        z = float2(z.x * z.x - z.y * z.y, 2 * z.x * z.y) + coord;
        float zz = dot(z, z);
        if (zz > 40000)
        {
            float sl = itr - log2(log2(zz)) + 4;
            return frac(sl / 100);
        }
    }

    return 0;
}

void Mandelbrot_float(float2 coord, out float3 output)
{
    output = Turbo(Mandelbrot(coord));
}
