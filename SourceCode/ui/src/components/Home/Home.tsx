/** @jsxImportSource @emotion/react */
import "@rmwc/card/styles";
import "@rmwc/typography/styles";
import { RootState } from "app/reducer/reducer";
import { setProductItems } from "app/slices/products.slice";
import { toggleLoading } from "app/slices/toggle.slice";
import Loader from "components/Loader/Loader";
import { isEmpty } from "lodash";

import { Product, ProductItem } from "models/utils.model";
import React from "react";
import { useState } from "react";
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useEffectOnce } from "react-use";
import { getProductItems } from "services/product.service";
import "twin.macro";
import tw from "twin.macro";
import { sleepAsync } from "utils/utils";
import { CustomCard } from "./CustomCard";

export const Home = () => {
  const [dataRender, setDataRender] = useState<ProductItem[][]>([]);

  const toggle = useSelector((state: RootState) => state.toggle);
  const product = useSelector((state: RootState) => state.product);

  const dispatch = useDispatch();

  const fakeSleep = async (milisecond: number) => {
    dispatch(toggleLoading(true));

    await sleepAsync(milisecond);

    dispatch(toggleLoading(false));
  };

  const handleDataRender = (products: Product[]) => {
    const newData: ProductItem[][] = [];
    let tempData: ProductItem[] = [];

    const firmSelected = product.idHangSelected;
    const typeSelected = product.idLoaiSelected;
    const currentItems = products.find((i) => i.id === firmSelected);

    currentItems?.loai
      .find((i) => i.ten.toLowerCase() === typeSelected)
      ?.products.forEach((item, index) => {
        if (index % 4 === 0) {
          newData.push(tempData);
          tempData = [];
        }
        tempData.push(item);
      });

    if (tempData.length > 0) {
      newData.push(tempData);
    }

    setDataRender(newData.filter((i) => !isEmpty(i)));
  };
  useEffectOnce(() => {
    (async () => {
      await fakeSleep(1500);
      const response = await getProductItems();

      const data = await response.data;
      dispatch(setProductItems(data));

      handleDataRender(data);
      await sleepAsync(1000);
    })();
  });

  useEffect(() => {
    (async () => {
      if (toggle.isLoading) return;

      await fakeSleep(1500);

      handleDataRender(product.items);
    })();

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [product.idHangSelected, product.idLoaiSelected]);
  return (
    <>
      <div tw="mt-16 mb-10">
        {toggle.isLoading && (
          <div className="loader__component">
            <Loader />
          </div>
        )}

        {dataRender.map((product) => {
          return (
            <div
              tw="mt-12 flex"
              css={[
                !toggle.isOpenSlideBar
                  ? tw`ml-32 duration-500`
                  : tw`ml-64 duration-500`,
              ]}
            >
              {product.map((item) => {
                return <CustomCard item={item} />;
              })}
            </div>
          );
        })}
      </div>
    </>
  );
};
