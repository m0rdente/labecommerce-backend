import { TUser, TProduct, TPurchase, Category } from "./types";

export const users: TUser[] = [
    {
        id: "1",
        name: "João das Neves",
        email: "joao.das.neves@gmail",
        password: "01020304",
        created_at: ""
    },  
    {
        id: "2",
        name: "Daenerys Targaryen",
        email: "daenerys.targaryen@gmail",
        password: "03984090",
        created_at: ""       
    }
];

export const products: TProduct[] = [
    {
        id: "1",
        name: "Roupa Espacial",
        price: 189,
        description: "Roupa Espacial multiplas cores",
        category: Category.SPACE_ACCESSORIES,
        image_url: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRbq4gQpn5ln9UNrzACo4KU5OPL5BN9x2c8GBZNDyeHVeo84Z-2tcK6ckayiZ5aegIbQvD5AbCYcDS1Ei_-nHqjgE_zr1seFZYC1s5nHfgs9t2xk-8xP9Ut"
    },
    {
        id: "2",
        name: "Telescópio",
        price: 499,
        description: "Acessórios espaciais",
        category: Category.SPACE_ACCESSORIES,
        image_url: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTeisvdC_dY86CoNR_r6jOodOScrCY-q7fwxzjabDFY5SbAmYkJQiinNGTlVf2G5-v0JrWt3cRRV_JFVRGz5xh1LmLGzGWJC9yQqv1Ipduz4fqQqy_2pP1C&usqp=CAE"
    }
];

export const purchases: TPurchase[] = [
    {
        id: "1",
        buyer: "1",
        total_price: 500,
        created_at: "",
        paid: 0 
    },
    {
      id: "2",
      buyer: "2",
      total_price: 500,
      created_at: "",
      paid: 0 
    }
];

  
  export function getAllUsers(users: TUser[]) : TUser[] {
    return users
  }
  

  export function getUserById(id: string) {
    const user = users.find((user) => user.id === id)
    return user
}

  export function getAllProducts(products: TProduct[]) : TProduct[] {
    return products
  }
  
  export function getProductById(idToSearch: string) : TProduct[] | undefined {
    return products.filter((product: TProduct) => {
      return product.id === idToSearch
    })
  }
  
  export function queryProductsByName (q: string) : TProduct[] {
    return products.filter((product: TProduct) => {
        return product.name.toLowerCase() === q
    })
  }
  

  
  export function getAllPurchasesFromUserId (id: string) : TPurchase[] | undefined {
    return purchases.filter((purchase) => {
        return purchase.id === id
    })

}