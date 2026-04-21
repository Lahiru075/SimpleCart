import { Router } from "express";
import { createProduct, deleteProduct, getallProducts, getProductById, updateProduct } from "../controller/product.controller";
import { upload } from "../middleware/upload";

const router = Router();

router.get('/', getallProducts);
router.get('/:id', getProductById);
router.post('/', upload.single('image'), createProduct);
router.put('/:id', upload.single('image'), updateProduct);
router.delete('/:id', deleteProduct);

export default router;