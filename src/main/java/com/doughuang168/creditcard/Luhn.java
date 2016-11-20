package com.doughuang168.creditcard;

        import java.util.*;
        import java.util.List;
        import java.util.stream.Collector;
        import java.util.stream.Collectors;
        import java.util.stream.Stream;

// Implementation of https://en.wikipedia.org/wiki/Luhn_algorithm
public class Luhn {

    public boolean isValidLuhn(String cardNumber){
        return checksum(cardNumber) == 0;
    }

//    public String generateCheckDigitV1(String cardNumber) {
//        List<Integer> lst = digitsOf(cardNumber);
//        List<Integer> oddlst = new ArrayList<>();
//        List<Integer> evenlst= new ArrayList<>();
//        for (int i = 0; i < lst.size(); i++) {
//            if (i%2 == 0) {
//                oddlst.add(lst.get(i));
//            } else {
//                Integer digit = (lst.get(i) * 2);
//                //if the product of this doubling operation is greater than 9
//                // (e.g., 8 × 2 = 16), then sum the digits of the products
//                // (e.g., 16: 1 + 6 = 7, 18: 1 + 8 = 9) or alternatively subtract 9 from the product
//
//                if ( digit > 9) {
//                    List<Integer> newLst = digitsOf(Integer.toString( digit ) );
//                    Integer d = newLst.stream().mapToInt((a) -> a).sum();
//                    evenlst.add(d);
//                } else {
//                    evenlst.add(digit);
//                }
//            }
//        }
//        Integer oddSum = oddlst.stream().mapToInt((a) -> a).sum();
//        Integer evenSum = evenlst.stream().mapToInt((a) -> a).sum();
//
//
//        //The check digit (x) is obtained by computing the sum of the non-check digits
//        // then computing 9 times that value modulo 10
//        // (in equation form, (67 × 9 mod 10)). In algorithm form
//        Integer chkDigit = ((oddSum + evenSum)*9) % 10;
//        return chkDigit.toString();
//    }

//    public String generateCheckDigitV2(String cardNumber) {
//        //To produce validation digit we can simply append "0" to source sequence
//        // and calculate Luhn checksum again.
//        // If last digit of the obtained checksum is zero then the validation digit is also zero,
//        // otherwise validation digit can be obtained
//        // by substracting last checksum digit from 10.
//
//        List<String> strlst = Arrays.stream("0123456789".split("\\B"))
//                .collect(Collectors.toList());
//        String checkDigit="";
//
//        if (isValidLuhn(cardNumber+"0")) {
//            checkDigit = "0";
//        } else {
//            Integer chksum = checksum(cardNumber);
//            System.out.println("chksum");
//            System.out.println(chksum);
//            Integer digit = 10 - checksum(cardNumber);
//            checkDigit = digit.toString();
//        }
//
////        for(String item : strlst){
////            if (isValidLuhn(cardNumber+item)) {
////                checkDigit = item;
////            }
////
////        }
//
//        return checkDigit;//chkDigit.toString();
//    }

    public String generateCheckDigit(String cardNumber) {
        //To produce validation digit we can simply append "0" to source sequence
        // and calculate Luhn checksum again.
        // If last digit of the obtained checksum is zero then the validation digit is also zero,
        // otherwise validation digit can be obtained
        // by substracting last checksum digit from 10.

        String checkDigit ="";
        if (isValidLuhn(cardNumber+"0")) {
            checkDigit = "0";
        } else {
            Integer d = checksum(cardNumber+"0");
            Integer digit = 10 - d;
            checkDigit = digit.toString();
        }
        return checkDigit;
    }


    public int numberOfValidLuhnNumbersInRange(String startRange, String endRange) {
        List<String> luhnNumbers = new ArrayList<>();
        if (isValidLuhn(startRange)) {
            luhnNumbers.add(startRange);
        }
        if (isValidLuhn(endRange)) {
            luhnNumbers.add(endRange);
        }
        List<String> strlst = Arrays.stream(endRange.split("\\B"))
                .collect(Collectors.toList());
        String str=startRange;
        for(String item : strlst){
            //System.out.println(item);
            str = str + item;
            if (isValidLuhn(str)) {
                luhnNumbers.add(str);
            }
        }
        return luhnNumbers.size();
    }

    private static <T> Collector<T, ?, Stream<T>> reversed() {
        return Collectors.collectingAndThen(Collectors.toList(), list -> {
            Collections.reverse(list);
            return list.stream();
        });
    }

    private List<Integer> digitsOf(String cardNumber) {

        List<Integer> d = Arrays.stream(cardNumber.split("\\B"))
                .map(s->Integer.valueOf(s))
                .collect(Collectors.toList());
        //System.out.println(d);
        return d;
    }

    private Integer checksum(String cardNumber) {

        List<Integer> lst = digitsOf(cardNumber);
        List<Integer> revertlst = lst.stream().collect(reversed()).collect(Collectors.toList());
        //System.out.println(revertlst);

        List<Integer> oddlst = new ArrayList<>();
        List<Integer> evenlst= new ArrayList<>();
        List<Integer> evenLstWithoutProductCorrection= new ArrayList<>();

        for (int i = 1; i < revertlst.size(); i++) {
            if (i%2 != 0) {
                evenLstWithoutProductCorrection.add(revertlst.get(i));
                Integer digit = (revertlst.get(i) * 2);
                //if the product of this doubling operation is greater than 9
                // (e.g., 8 × 2 = 16), then sum the digits of the products
                // (e.g., 16: 1 + 6 = 7, 18: 1 + 8 = 9) or alternatively subtract 9 from the product
                if ( digit > 9) {
                    List<Integer> newLst = digitsOf(Integer.toString( digit ) );
                    Integer d = newLst.stream().mapToInt((a) -> a).sum();
                    evenlst.add(d);
                } else {
                    evenlst.add(digit);
                }
            }
        }

        for (int i = 0; i < revertlst.size(); i++) {
            if (i%2 == 0) {
                //System.out.println(i);
                oddlst.add(revertlst.get(i));
            }
        }

        Integer oddSum = oddlst.stream().mapToInt((a) -> a).sum();
        Integer evenSum = evenlst.stream().mapToInt((a) -> a).sum();

        return (oddSum + evenSum) % 10;
    }
}
