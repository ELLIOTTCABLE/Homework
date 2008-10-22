////////////////////////////////////////////////////////////////////////////
//
//	elliottcable
// 	Assignment 5, Programming Project 12
//	October 22, 2008
//
////////////////////////////////////////////////////////////////////////////
package name.elliottcable.tests;
import  name.elliottcable.homework.Rational;

import org.junit.*;
import static org.junit.Assert.*;

public class RationalTest {
  Rational rationalNumber;
  
  @Before public void setUp() {
    rationalNumber = new Rational();
  }
  
  @Test public void testNumeratorBean() {
    rationalNumber.setNumerator(123);
    assertEquals( (int)rationalNumber.getNumerator(), 123 );
    assertNotNull( rationalNumber.numerator );
  }
  
  @Test public void testDenominatorBean() {
    rationalNumber.setDenominator(456);
    assertEquals( (int)rationalNumber.getDenominator(), 456 );
    assertNotNull( rationalNumber.denominator );
  }
  
}