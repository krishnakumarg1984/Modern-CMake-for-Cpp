#include "calc.h"

#include <gtest/gtest.h>

class CalcTestSuite : public ::testing::Test {
  protected:
    Calc sut_;
};

TEST_F(CalcTestSuite, SumAddsTwoInts) {
    EXPECT_EQ(4, sut_.Sum(2, 2));
}

TEST_F(CalcTestSuite, MultiplyMultipliesTwoInts) {
    EXPECT_EQ(12, sut_.Multiply(3, 4));
}
