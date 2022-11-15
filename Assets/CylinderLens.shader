Shader "Unlit/CylinderLens"
{
	Properties
	{
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 worldPosition : TEXCOORD0;
			};

			sampler2D _MainTex;
			float _Radius;
			float4 _NU;
			float4 _NV;
			float4 _SRC;
			float4 _CameraPosition;
			float4 _Forward;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}

			float4 getRefPoint_Bisection(float4 worldPosition)//二分法
			{
				float4 wp2d = float4(worldPosition.x, 0, worldPosition.z, 0);
				float4 cp2d = float4(_CameraPosition.x, 0, _CameraPosition.z, 0);
				float4 spn = normalize(wp2d);
				float4 epn = normalize(cp2d);
				float4 cpn = normalize(spn + epn);
				float4 cp = cpn * _Radius;
				//1
				float ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//2
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//3
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//4
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//5
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//6
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//7
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//8
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//9
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//10
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//11
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//12
				ds = (sign(dot(cpn, normalize(cp2d - cp)) - dot(cpn, normalize(wp2d - cp))) + 1) * .5;
				spn = spn * ds + cpn * (1 - ds);
				epn = cpn * ds + epn * (1 - ds);
				cpn = normalize(spn + epn);
				cp = cpn * _Radius;
				//13

				float wd2d = length(wp2d - cp);
				float cd2d = length(cp2d - cp);
				cp.y = (worldPosition.y * cd2d + _CameraPosition.y * wd2d) / (wd2d + cd2d);
				return cp;
			}
			float2 getUV(float4 refPoint)
			{
				float4 wd = refPoint - _CameraPosition;
				float4 p = wd / dot(wd, _Forward) * dot(_Forward, _Forward) + _CameraPosition - _SRC;
				return float2(dot(p, _NU) / dot(_NU, _NU), dot(p, _NV) / dot(_NV, _NV));
			}
			fixed4 frag(v2f i) : SV_Target
			{
				float4 refPoint = getRefPoint_Bisection(i.worldPosition);
				float2 uv = getUV(refPoint);
				float4 color = tex2D(_MainTex,uv);
				return color;
			}
			ENDCG
		}
	}
}
