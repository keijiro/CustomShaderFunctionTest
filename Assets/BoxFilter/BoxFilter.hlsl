void BoxFilter_float
  (Texture2D source, float2 uv, float width, SamplerState state,
   out float4 output)
{
    const uint taps = 5;

    float4 acc = 0;

    for (uint y = 0; y < taps; y++)
    {
        for (uint x = 0; x < taps; x++)
        {
            float2 displace = float2(x, y) - (taps - 1) / 2.0;
            acc += source.Sample(state, uv + displace * width / taps);
        }
    }

    output = acc / (taps * taps);
}
