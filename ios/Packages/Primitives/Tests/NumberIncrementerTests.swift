@testable import Primitives
import Testing

struct NumberIncrementerTests {
    @Test
    func incrementsFromZero() {
        let incrementer = NumberIncrementer(0)

        #expect(incrementer.next() == 0)
        #expect(incrementer.next() == 1)
    }

    @Test
    func incrementsFromTimestamp() {
        let timestamp = 1_704_067_200
        let incrementer = NumberIncrementer(timestamp)

        #expect(incrementer.next() == 1_704_067_200)
        #expect(incrementer.next() == 1_704_067_201)
    }
}
