package com.example.wanted.service;

import com.example.wanted.model.*;
import com.example.wanted.repository.ImagesRepository;
import com.example.wanted.repository.LabelsRepository;
import com.example.wanted.repository.ProductRepository;
import com.example.wanted.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final ImagesRepository imagesRepository;
    private final LabelsRepository labelsRepository;
    private final UserRepository userRepository;


    @Autowired
    public ProductService(@Qualifier("product") ProductRepository productRepository, @Qualifier("images") ImagesRepository imagesRepository, @Qualifier("labels")LabelsRepository labelsRepository,@Qualifier("user") UserRepository userRepository) {
        this.productRepository = productRepository;
        this.imagesRepository = imagesRepository;
        this.labelsRepository = labelsRepository;
        this.userRepository = userRepository;
    }

    String os = System.getProperty("os.name");

    public List<ProductSend> getProductList(){
        List<Product> productList= productRepository.findAll();
        List<ProductSend> productSends= new ArrayList<>();
        for(int i=0;i<productList.size();i++){
            Product p = productList.get(i);
            ProductSend productSend = new ProductSend(p.getProductId(),p.getImages().getId(),p.getLabels().getId(),p.getUser().getId(),p.getName(), p.getDescription(), p.getLocation(), p.getPrice());
            productSends.add(productSend);
        }
        return productSends;
    }

    public Labels saveLabel(List<String> labels){
        //去掉[和]
        Labels labelsModel = new Labels();
        for(int i = labels.size();i<6;i++){
            labels.add("");
        }
        String label1 = labels.get(0).replace("[","");
        labelsModel.setLabel1(label1.replace("]",""));
        labelsModel.setLabel2(labels.get(1).replace("]",""));
        labelsModel.setLabel3(labels.get(2).replace("]",""));
        labelsModel.setLabel4(labels.get(3).replace("]",""));
        labelsModel.setLabel5(labels.get(4).replace("]",""));
        labelsModel.setLabel6(labels.get(5).replace("]",""));
        labelsRepository.save(labelsModel);
        return labelsModel;
    }

    public Images saveImage(MultipartFile[] images) throws FileNotFoundException {
        //String uploadPath = "/static/pictures";
        File pathfile = new File(ResourceUtils.getURL("classpath:").getPath());
        if(!pathfile.exists()) {

            pathfile = new File("");
        }
        File upload = new File(pathfile.getAbsolutePath(),"/static/upload/");
        if(!upload.exists()) {

            upload.mkdirs();
        }

        //String uploadPath = "D://wantedPictures";
        Images imagesModel = new Images();

        for(int i = 0; i<images.length;i++){
            try{
                byte[] bytes = images[i].getBytes();
                Path path = Paths.get(upload.getPath()+"/"+images[i].getOriginalFilename());
                Files.write(path,bytes);
                //去D://....路徑
                String pathStr = path.toString().replace(upload.getPath(),"");

               // if (os.toLowerCase().startsWith("win")){
               //     pathStr = pathStr.replace("//","");
               // }else{
                pathStr = pathStr.replace("\\","");
               // }
                switch (i){
                    case 0:
                        imagesModel.setImage1(pathStr);
                        break;
                    case 1:
                        imagesModel.setImage2(pathStr);
                        break;
                    case 2:
                        imagesModel.setImage3(pathStr);
                        break;
                    case 3:
                        imagesModel.setImage4(pathStr);
                        break;
                    case 4:
                        imagesModel.setImage5(pathStr);
                        break;
                    case 5:
                        imagesModel.setImage6(pathStr);
                        break;
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        imagesRepository.save(imagesModel);
        return imagesModel;

    }

    public Long saveProduct(String description,String name,String location,String price,Labels labelsModel,Images imagesModel,int userId){
        Product product = new Product(name,description,location,Float.parseFloat(price));
        User user = userRepository.findById(userId).get();
        product.setUser(user);
        product.setImages(imagesModel);
        product.setLabels(labelsModel);
        productRepository.save(product);
        return product.getProductId();
    }

}
