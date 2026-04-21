import { Request, Response } from "express";
import { Product } from "../model/product.model";
import { resolve } from "node:dns";
import cloudinary from "../config/cloudinary";


export const getallProducts = async (req: Request, res: Response) => {
    try {
        const products = await Product.find();
        res.status(200).json({ data: products });
    } catch (error) {
        res.status(500).json({ message: "Error fetching products ", error });
    }
}

export const getProductById = async (req: Request, res: Response) => {
    try {
        const id = req.params.id;

        const product = await Product.findById(id);

        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }

        res.status(200).json({ data: product });

    } catch (error) {
        res.status(500).json({ message: "Error fetching product ", error });
    }
}

export const createProduct = async (req: Request | any, res: Response) => {

    try {

        const { name, price, description, category } = req.body;

        if (!name || !price || !description || !category) {
            return res.status(400).json({ message: "All fields are required" });
        }

        let newProduct = new Product({
            name,
            price,
            description,
            category
        })

        if (req.file) {
            const result: any = await new Promise((resolve, reject) => {
                const upload_stream = cloudinary.uploader.upload_stream(
                    { folder: "SimpleCartApp" },
                    (error, result) => {
                        if (error) {
                            console.error(error)
                            return reject(error)
                        }
                        resolve(result)
                    }
                )
                upload_stream.end(req.file?.buffer)
            })
            newProduct.imageUrl = result.secure_url;
        }


        const savedProduct = await newProduct.save();
        res.status(201).json({ data: savedProduct });
    } catch (error) {
        res.status(500).json({ message: "Error creating product ", error });
    }
}

export const updateProduct = async (req: Request | any, res: Response) => {

    try {

        const id = req.params.id;
        const { name, price, description, category } = req.body;

        if (!name || !price || !description || !category) {
            return res.status(400).json({ message: "All fields are required" });
        }


        const product = await Product.findById(id);

        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }

        product.name = name;
        product.price = price;
        product.description = description;
        product.category = category;
        
        if (req.file) {
            const result: any = await new Promise((resolve, reject) => {
                const upload_stream = cloudinary.uploader.upload_stream(
                    { folder: "SimpleCartApp" },
                    (error, result) => {
                        if (error) {
                            console.error(error)
                            return reject(error)
                        }
                        resolve(result)
                    }
                )
                upload_stream.end(req.file?.buffer)
            })
            product.imageUrl = result.secure_url;
        }

        const updatedProduct = await product.save();
        res.status(200).json({ data: updatedProduct });


    } catch (error) {
        res.status(500).json({ message: "Error updating product ", error });
    }
}

export const deleteProduct = async (req: Request, res: Response) => {

    try {
        const id = req.params.id;

        const product = await Product.findById(id);

        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }

        await product.deleteOne();
        res.status(200).json({ message: "Product deleted successfully" });

    } catch (error) {
        res.status(500).json({ message: "Error deleting product ", error });
    }
}