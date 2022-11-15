using UnityEngine;


namespace NameSpace
{
    [ExecuteAlways]
    public class Look : MonoBehaviour
    {
        public Transform target;
        public new Camera camera;
        public Material material;
        public float radius = 1;
        private void Update()
        {
            if (target) transform.LookAt(target, Vector3.up);
            if (camera && material)
            {
                var angle = camera.fieldOfView * .5f * Mathf.Deg2Rad;
                var dis = camera.nearClipPlane * Mathf.Tan(angle);
                var center = transform.position + transform.forward * camera.nearClipPlane;
                var up = transform.up * dis;
                var right = transform.right * dis;
                material.SetFloat(_radius, radius);
                material.SetVector(_nu, right * 2);
                material.SetVector(_nv, up * 2);
                material.SetVector(_src, center - up - right);
                material.SetVector(_camera, transform.position);
                material.SetVector(_forawrd, transform.forward * camera.nearClipPlane);
            }
        }
        private static readonly int _radius = Shader.PropertyToID("_Radius");
        private static readonly int _nu = Shader.PropertyToID("_NU");
        private static readonly int _nv = Shader.PropertyToID("_NV");
        private static readonly int _src = Shader.PropertyToID("_SRC");
        private static readonly int _camera = Shader.PropertyToID("_CameraPosition");
        private static readonly int _forawrd = Shader.PropertyToID("_Forward");
    }
}