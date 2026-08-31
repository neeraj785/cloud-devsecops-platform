import React, { useState, useEffect } from 'react';
import { getProducts, createOrder } from "./api";

function App() {
    const [products, setProducts] = useState([]);
    const [message, setMessage] = useState("");

    useEffect(() => {
        getProducts()
            .then(data => {
                setProducts(data);
            })
            .catch(error => {
                console.error(error);
                setMessage("Unable to load products");
            });
    }, []);

    async function orderProduct(productId) {
        try {
            const result = await createOrder(productId);
            setMessage(`Order created successfully. Order ID: ${result.order_id}`);
        } catch (error) {
            console.error(error);
            setMessage("Failed to create order");
        }
    }

    return (
        <div style={{
            maxWidth: "900px",
            margin: "40px auto",
            fontFamily: "Arial"
        }}>
            <h1>CloudShop</h1>
            <h2>Products</h2>

            {products.map(product => (
                <div
                    key={product.id}
                    style={{
                        border: "1px solid #ddd",
                        padding: "20px",
                        marginBottom: "15px"
                    }}
                >
                    <h3>{product.name}</h3>
                    <p>₹{product.price}</p>
                    <button onClick={() => orderProduct(product.id)}>
                        Place Order
                    </button>
                </div>
            ))}

            {message && (
                <p style={{ marginTop: "20px", fontWeight: "bold" }}>
                    {message}
                </p>
            )}
        </div>
    );
}

export default App;
