Shader "Hidden/Rim"
{
    Properties
    {
        _BaceColor ("BaceColor", Color) = (1, 1, 1, 1)
        _RimColor ("RimColor", Color) = (1, 0, 0, 1)
    }
    SubShader
    {
        // No culling or depth
        //Cull Off  ZTest Always
        
        
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
                float3 normal: NORMAL;
            };
            
            struct v2f
            {
                float2 uv: TEXCOORD0;
                float4 vertex: SV_POSITION;
                float3 normal: NORMAL;
                float3 vieDir: TEXCOORD1;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.vieDir = WorldSpaceViewDir(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            
            float4 _BaceColor;
            float4 _RimColor;
            
            fixed4 frag(v2f i): SV_Target
            {
                //float rim   = pow(1.0 - clamp(dot(i.normal, i.vieDir), 0.0, 1.0), 5.0);
                float rim = 1 - clamp((dot(i.normal, i.vieDir)),0,1);
                return _BaceColor + _RimColor * rim;
            }
            ENDCG
            
        }
    }
}
