import { Router } from "express";
import { addToWishlist, getWishlist, removeFromWishlist } from "../controller/wishlist.controller";

const router = Router();

router.get('/', getWishlist);
router.post('/', addToWishlist);
router.delete('/:id', removeFromWishlist);

export default router;