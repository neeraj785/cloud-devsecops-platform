const API_URL =
    import.meta.env.VITE_API_URL ||
    "http://localhost:5000/api";


export async function getProducts() {

    const response = await fetch(
        `${API_URL}/products`
    );

    if (!response.ok) {
        throw new Error("Failed to fetch products");
    }

    return response.json();
}


export async function createOrder(productId) {

    const response = await fetch(
        `${API_URL}/orders`,
        {
            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                product_id: productId,
                quantity: 1
            })
        }
    );

    if (!response.ok) {
        throw new Error("Failed to create order");
    }

    return response.json();
}
