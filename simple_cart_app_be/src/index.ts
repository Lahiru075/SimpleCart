import dotenv from 'dotenv';
import express from 'express';
import cors from 'cors';
import mongoose from 'mongoose';
dotenv.config();

import productRoute from './routes/product.routes';
import wishlistRoute from './routes/wishlist.routes';

const SERVER_PORT = process.env.SERVER_PORT || 5000;
const MONGO_URI = process.env.MONGO_URI as string;

const app = express();

app.use(express.json());

app.use(
    cors({
        origin: '*',
        methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
    })
);

app.use('/api/products', productRoute);
app.use('/api/wishlist', wishlistRoute);

// add mongoDB atlas connection

mongoose
    .connect(MONGO_URI)
    .then(() => {
        console.log('DB connected');
    })
    .catch((error) => {
        console.error(`DB connection fail: ${error}`);
    });

app.listen(SERVER_PORT, () => {
    console.log(`Server is running on port ${SERVER_PORT}`);
});