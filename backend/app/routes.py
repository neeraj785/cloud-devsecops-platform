from flask import Blueprint, jsonify, request
from .database import get_connection

api = Blueprint("api", __name__)


@api.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "UP"
    })


@api.route("/products", methods=["GET"])
def products():

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute(
        "SELECT id, name, price FROM products ORDER BY id"
    )

    rows = cursor.fetchall()

    cursor.close()
    connection.close()

    products = []

    for row in rows:
        products.append({
            "id": row[0],
            "name": row[1],
            "price": float(row[2])
        })

    return jsonify(products)


@api.route("/orders", methods=["POST"])
def create_order():

    data = request.get_json()

    product_id = data.get("product_id")
    quantity = data.get("quantity", 1)

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute(
        """
        INSERT INTO orders (product_id, quantity)
        VALUES (%s, %s)
        RETURNING id
        """,
        (product_id, quantity)
    )

    order_id = cursor.fetchone()[0]

    connection.commit()

    cursor.close()
    connection.close()

    return jsonify({
        "message": "Order created successfully",
        "order_id": order_id
    }), 201