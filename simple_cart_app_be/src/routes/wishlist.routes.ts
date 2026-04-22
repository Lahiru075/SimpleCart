import { Router } from "express";
import { addToWishlist, checkWishlist, getWishlist, removeFromWishlist } from "../controller/wishlist.controller";

const router = Router();

router.get('/', getWishlist);
router.post('/', addToWishlist);
router.delete('/:id', removeFromWishlist);
router.get('/check/:id', checkWishlist);

export default router;