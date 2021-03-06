package com.doughuang168.creditcard.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.doughuang168.creditcard.Response;
import com.doughuang168.creditcard.Luhn;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.atomic.AtomicLong;

@Controller
@RequestMapping("/api")
public class LuhnController {
     /**
     * Inject property.
     */
    @Value("${luhn.api.key}")
    private String luhnApiKey;

    private static final String template = "%s";
    private final AtomicLong counter = new AtomicLong();

    @RequestMapping(value="/validate/{cardnumber}",method= RequestMethod.GET)
    public @ResponseBody
    Response isValidLuhn(@PathVariable("cardnumber") String cardnumber,
                         @RequestHeader(value = "X-API-KEY", defaultValue = "Default-X-API-KEY") String key
                      )
    {
        Luhn luhnInstance = new Luhn();
        String result="";
        String message="";

        if (!key.contentEquals(luhnApiKey)) {
            //System.out.println(luhnApiKey);
            //System.out.println(key);

            message= "invalid api key";
            return new Response(counter.incrementAndGet(),
                    "Error",
                    String.format(template, message),
                    result
            );
        }
        

        if (luhnInstance.isValidLuhn(cardnumber)) {
            System.out.println("valid card");
            message= cardnumber+" is valid Luhn number";
            result="true";
        } else {
            System.out.println("invalid card");
            message=cardnumber+" is invalid Luhn number";
            result="false";
        }

        return new Response(counter.incrementAndGet(),
                            "OK",
                            String.format(template, message),
                            result
                            );
    }


    @RequestMapping(value="/checkdigit/{cardnumber}",method= RequestMethod.GET)
    public @ResponseBody
    Response generateCheckDigit(@PathVariable("cardnumber") String cardnumber,
                                @RequestHeader(value = "X-API-KEY", defaultValue = "Default-X-API-KEY") String key
    )
    {
        Luhn luhnInstance = new Luhn();
        String message="";
        String result="";
        if (!key.contentEquals(luhnApiKey)) {
            message= "invalid api key";
            return new Response(counter.incrementAndGet(),
                    "Error",
                    String.format(template, message),
                    result
            );
        }

        String chkDigit = luhnInstance.generateCheckDigit(cardnumber);
        message="Check digit is "+chkDigit;
        return new Response(counter.incrementAndGet(),
                            "OK",
                            String.format(template, message),
                            chkDigit
                            );
    }



    @RequestMapping(value="/validcardnumber",method= RequestMethod.GET)
    public @ResponseBody
    Response numberOfValidLuhnNumbersInRange(
                                @RequestParam(value="startRange",  required=true,
                                                defaultValue="startRange") String startRange,
                                @RequestParam(value="endRange",  required=true,
                                        defaultValue="endRange") String endRange,
                                @RequestHeader(value = "X-API-KEY", defaultValue = "Default-X-API-KEY") String key
    )
    {
        Luhn luhnInstance = new Luhn();
        String message="";
        String result="";
        if (!key.contentEquals(luhnApiKey)) {
            message= "invalid api key";
            return new Response(counter.incrementAndGet(),
                    "Error",
                    String.format(template, message),
                    result
            );
        }

        Integer numbers = luhnInstance.numberOfValidLuhnNumbersInRange(startRange,endRange);
        message="Number Of Valid LuhnNumbers In Range is "+numbers.toString();
        return new Response(counter.incrementAndGet(),
                            "OK",
                            String.format(template, message),
                            numbers.toString()
                            );
    }
}
