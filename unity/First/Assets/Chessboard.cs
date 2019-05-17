using UnityEngine;
using System.Collections;

public class Chessboard : MonoBehaviour {
	
	Mesh mesh;
	MeshFilter meshFilter;
	public Material material;
	public Texture2D texture;
	
	// Use this for initialization
	void Start () {
		material.mainTexture = texture;
		
		mesh = new Mesh();
		mesh.name = "mesh";
		meshFilter = gameObject.AddComponent<MeshFilter>();
		gameObject.AddComponent<MeshRenderer>();
		meshFilter.sharedMesh = mesh;
		renderer.sharedMaterial = material;
		defineMesh();
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(new Vector3(Time.deltaTime*60, 0, 0));
		makeTexture();
	}
	
	void makeTexture () {
		Debug.Log("width = " + texture.width);
		Debug.Log("height = " + texture.height);
		int w = texture.width;
		int h = texture.height;
		int n = w*h;
		Color[] col = texture.GetPixels;
		for (int i = 0; i < n; i++) {
			col[i] = Color.white;
		}
		texture.SetPixels(col);
		material.mainTexture = texture;
	}
	
	void defineMesh () {
		// vertices, triangles, normals, UVs
		Vector3[] vertices = new Vector3[]{
			new Vector3( 10, 10, 0),
			new Vector3(-10, 10, 0),
			new Vector3(-10,-10, 0),
			new Vector3( 10,-10, 0),
			new Vector3( 10, 10, 0),
			new Vector3(-10, 10, 0),
			new Vector3(-10,-10, 0),
			new Vector3( 10,-10, 0)};
		
		int[] triangles = new int[]{0, 1, 2, 0, 2, 3, 4, 6, 5, 4, 7, 6};
		
		Vector3[] normals = new Vector3[]{
			new Vector3( 0, 0, 1),
			new Vector3( 0, 0, 1),
			new Vector3( 0, 0, 1),
			new Vector3( 0, 0, 1),
			new Vector3( 0, 0,-1),
			new Vector3( 0, 0,-1),
			new Vector3( 0, 0,-1),
			new Vector3( 0, 0,-1)};
		
		Vector2[] UVs = new Vector2[]{
			new Vector2( 1, 1),
			new Vector2( 0, 1),
			new Vector2( 0, 0),
			new Vector2( 1, 0),
			new Vector2( 1, 1),
			new Vector2( 0, 1),
			new Vector2( 0, 0),
			new Vector2( 1, 0)};
		
		mesh.vertices = vertices;
		mesh.uv = UVs;
		mesh.triangles = triangles;
		mesh.normals = normals;
	}
}
