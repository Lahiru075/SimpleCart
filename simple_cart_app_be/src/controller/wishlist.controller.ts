import { Request, Response } from "express";
import { Wishlist } from "../model/wishlist.model";

export const getWishlist = async (req: Request, res: Response) => {
    try {
        const userId = "user123";

        const wishlist = await Wishlist.find({ userId }).populate('productId');

        res.status(200).json({data: wishlist});

    } catch (error) {
        res.status(500).json({ message: "Error fetching wishlist", error });
    }
}

export const addToWishlist = async (req: Request, res: Response) => {
    try {
        const { productId } = req.body;
        const userId = "user123";

        const existingItem = await Wishlist.findOne({ userId, productId });

        if (existingItem) {
            return res.status(400).json({ message: "Product already in wishlist" });
        }

        const newItem = await Wishlist.create({ userId, productId });

        res.status(201).json({ message: "Product added to wishlist", data: newItem });

    } catch (error) {
        res.status(500).json({ message: "Error adding product to wishlist", error });
    }
}

export const removeFromWishlist = async (req: Request, res: Response) => {
    try {
        const { id } = req.params;
        await Wishlist.findByIdAndDelete(id);
        res.status(200).json({ message: "Product removed from wishlist" });
    } catch (error) {
        res.status(500).json({ message: "Error removing product from wishlist", error });
    }
}