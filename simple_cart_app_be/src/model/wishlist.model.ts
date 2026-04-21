import mongoose, { Schema, Document } from 'mongoose';

export interface IWishlist extends Document {
    userId: string;
    productId: mongoose.Types.ObjectId;
    addedAt: Date;
}

const WishlistSchema: Schema = new Schema({
    userId: { type: String, required: true },
    productId: { type: mongoose.Schema.Types.ObjectId, ref: 'Product', required: true },
}, {
    timestamps: true
});

export const Wishlist = mongoose.model<IWishlist>('Wishlist', WishlistSchema);