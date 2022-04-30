
import { serverInit } from 'config/config';
import { Login } from 'controllers/Auth/Login/Login';
import { getProduct } from 'controllers/Product/getProduct';
import { Detail } from 'controllers/Product/getDetail';
import express from 'express';
import { addBill } from 'controllers/Bill/addBill';
import { createStripe } from 'controllers/Bill/createStripe';
import { momoSNS } from 'controllers/Bill/momoSNS';

const app = express();

export const routes = () => {
    serverInit(app);

    app.use("/auth/signin", Login());
    app.use("/product/getProduct", getProduct());
    app.use("/product/getDetail", Detail());
    app.use("/bill/addBill", addBill());

    app.use("/create-checkout-session", createStripe());

    app.use("/pay", momoSNS());
    // app.use("/pay/checkMomo", checkMomo());

}